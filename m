Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWCODZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWCODZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWCODZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:25:51 -0500
Received: from web52605.mail.yahoo.com ([206.190.48.208]:33725 "HELO
	web52605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964799AbWCODZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:25:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wSeXvi8/KA4BcxtCTfNd0OaBpruM+ZiK1Vj/DVHAb57XCA5X1Nqg+innvnX35ue8clm1fVzOTHlyIFMTb11fDv049/OvpygGTr1pKjCldVeRsg3ll8NUF7q1mJjNYrmjFFcPSS8D8BNWBltFQVRt8RcBiz4sPZx6L+q8D/ftyJg=  ;
Message-ID: <20060315032549.83543.qmail@web52605.mail.yahoo.com>
Date: Wed, 15 Mar 2006 14:25:49 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: Module Ref Counting & ibmphp
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org
In-Reply-To: <20060315000212.GB6533@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Greg KH <greg@kroah.com> wrote:
> [...] 
> No.  I don't think this driver likes to be unloaded
> due to the
> instability of the hardware if that happens.  So
> let's just let it not
> be unloaded, and hope that the hardware can die in
> peace and never get
> put into any new machines...

Fair enough & thanks for the explanation.

I've quickly tested Stephen's patch, which does the
trick (no more 4.3 billion usages :)).

Note to Stephen: Pls don't remove people in the cc
list. I almost missed your patch & hence my testing of
it.

Thanks



		
___________________________________________________ 
On Yahoo!7 
Desperate Housewives: Sneak peeks, recaps and more. 
http://www.yahoo7.com.au/desperate-housewives 

