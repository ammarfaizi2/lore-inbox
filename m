Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWGYWnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWGYWnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWGYWnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:43:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:46986 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751603AbWGYWnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:43:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bt01TK/xwdlfukfLAN2jdeTk03TQuaTHJEpvMBVYxVFyeCgcULU9hLTPjOg0RE5ej/YkWqD21oStWdX8049yBPHrUYIKZlATYQeZvUJMXKkbTpaCmj4Wb0SMiQyqXPw3DPa7PQd7vfk8bgVquKzxqrZLVDgPm/8NblmDodO5NOQ=
Message-ID: <9a8748490607251543w7496864dtd587abc45b93394a@mail.gmail.com>
Date: Wed, 26 Jul 2006 00:43:06 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] CCISS: Don't print driver version until we actually find a device
Cc: "Andrew Morton" <akpm@osdl.org>, "Mike Miller" <mike.miller@hp.com>,
       iss_storagedev@hp.com, linux-kernel@vger.kernel.org
In-Reply-To: <200607251636.42765.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607251636.42765.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> If we don't find any devices, we shouldn't print anything.
>
I disagree.
I find it quite nice to be able to see that the driver loaded even if
it finds nothing. At least then when there's a problem, I can quickly
see that at least it is not because I didn't forget to load the
driver, it's something else. Saves time since I can start looking for
reasons why the driver didn't find anything without first spending
additional time checking if I failed to cause it to load for some
reason.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
