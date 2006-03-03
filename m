Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWCCNMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWCCNMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCCNMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:12:49 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:57136 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751122AbWCCNMs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:12:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q5T5TO4sAYQLRWZD3t0ZNPEs4IF96N4fekH+W8QcXVoCWBKIwssdY4jaLwgY7Wv9GfnG3VAEK2sExoRFay5zDD7kDDPIuqziRnb2RZaPD0jWdOzrjuWCL1wHsoBvAt5vuCYRcsS62lXsqwuRarVo9RqfQSSwixeZTsFqHuwEWOM=
Message-ID: <c43b2e150603030512l141c101va11300bcfbda4f60@mail.gmail.com>
Date: Fri, 3 Mar 2006 14:12:46 +0100
From: wixor <wixorpeek@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: using usblp with ppdev?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060302165557.GA31247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com>
	 <20060302165557.GA31247@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Anyway, no, the usblp driver is not what you want, you probably want the
> uss720 driver, which does register with parport.
>
But the problem is the uss720 driver is limited to one chip and
doesn't see my cable! Is this chip the only one capable of doing
direct i/o on port pins? Thanks.
