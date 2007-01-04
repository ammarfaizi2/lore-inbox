Return-Path: <linux-kernel-owner+w=401wt.eu-S1750971AbXADTUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbXADTUz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbXADTUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:20:54 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:21950 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbXADTUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:20:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UwxdFkDkmU7jJUd7kYJFXqVB5eEyDS8evP7ahEwzrNfXMVNl3ptPLDwbtEAFyGCp7P14QkERwC7WFYw4bMQRKc+F72UKvoERifFJ6o7Nu+qn+l3fY1Nu536+eIvqu6VO6poVGBdGxpr53HUcGsPE+raM4BktKWLujFCljwC6sqc=
Message-ID: <84144f020701041120g78ab1371v8a7ae4e3272af3ad@mail.gmail.com>
Date: Thu, 4 Jan 2007 21:20:52 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
Cc: "Andrew Morton" <akpm@osdl.org>, "Christoph Lameter" <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0701041840360.23501@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
	 <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
	 <Pine.LNX.4.64.0701041840360.23501@blonde.wat.veritas.com>
X-Google-Sender-Auth: 1cea26dfd482781c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/07, Hugh Dickins <hugh@veritas.com> wrote:
> That does indeed look more tasteful.  But there appears to be a fair
> bit more refactoring one would want to do, if aiming for good taste
> there: the kmem_flagcheck, the conditional local_irq_dis/enable...
> I think I'll leave that to you and Christoph to fight over later!

Fair enough :-)

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
