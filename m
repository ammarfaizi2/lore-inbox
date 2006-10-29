Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWJ2MEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWJ2MEe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWJ2MEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:04:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:28851 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932291AbWJ2MEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:04:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lwnThnAcZCYuQ/PnnQJyZKkkGfDRCerL4VUOe2zcEP7l6591L69K+/vds8godB5PLJO+1A3rCPOn+lI7S4wFar8K2q8jC8WfF9HcJJ6v3uW+W+X36vB1zjwkPmzrR0lA6koZB0vgI0yZae+i+dkjtQ7rsSDKgdV7Xr4z3qRhy/o=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: why "probe_kernel_address()", not "probe_user_address()"?
Date: Sun, 29 Oct 2006 14:02:33 +0100
User-Agent: KMail/1.8.2
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, linux-kernel@vger.kernel.org
References: <20061028203014.GA7183@dreamland.darkstar.lan>
In-Reply-To: <20061028203014.GA7183@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610291402.33890.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 22:30, Luca Tettamanti wrote:
> probe_kernel_address wrapper is used to "hide" the fact that we are
> re-using the infrastructure provided by a function with a confusing name
> ;) The cast to __user is needed to keep sparse quiet.

Shouldn't the above text be placed in a comment above probe_kernel_address()
definition? ;)
--
vda
