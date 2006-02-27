Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWB0T0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWB0T0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWB0T0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:26:14 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:12171 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751745AbWB0T0N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:26:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p5FRs1/wKNAQ1KdPkLvoipJh7LazXeQWVY7ERUVDY+UhaTh4Yr/3yOjyC+/er3jNenfZB61xqJ2AHchwuPlLXPceKg01Te9HBRlDlisQosVWHRZWHngBOWPT1qEZmSR8grO3SWOpENWL4/5iIcUfO+eqBF6gvWBj3a/7OSAD7eY=
Message-ID: <4807377b0602271126s39285884gd0e1c51c14b5d6a7@mail.gmail.com>
Date: Mon, 27 Feb 2006 11:26:12 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Paul Rolland" <rol@witbe.net>, "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: [2.4.32 - 2.6.15.4] e1000 - Fix mii interface
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, cramerj@intel.com, john.ronciak@intel.com
In-Reply-To: <01e101c63ae7$1b417990$2001a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602260700s2e82a623mcf2d778aa109bb00@mail.gmail.com>
	 <01e101c63ae7$1b417990$2001a8c0@cortex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Paul Rolland <rol@witbe.net> wrote:
> Hello,
>
> > Ok, great, I was just wondering since I would have made one if you had
> > no plans to do so.
>
> Well, I was just waiting to make sure it was interesting for someone ;)
>
> Here is it, verified with tab and not spaces... but attached as my mailer
> is likely to cripple anything I try to inline...
>
> Signed-off-by: Paul Rolland <rol@as2917.net>

I've got an issue with this, as the same function is called in
e1000_ethtool.c.  I think the correct fix is to fix the caller in the
mii-tool case, but I am working on verifiying my assumptions.

In the meantime can you send the exact command you were having the problem with?
