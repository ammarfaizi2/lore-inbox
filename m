Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWAWCnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWAWCnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWAWCnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:43:09 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:58902 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751389AbWAWCnI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:43:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=R7aHUcSnWTchg1O4TRAhZ0JBn7kzGPiNhve7lJQchIn5MiCmpuXXFXdjfYnRUU6BmefWK41fV7Aw6p68G0xKsQgdP7flL2H3ME+hojq8Vy6cRMv4rLXAKqaXvKqffcpJj9Kb8nfdFA128y5AFnHFMvh+uorrkJOSuEMOPs1XaWk=
Date: Mon, 23 Jan 2006 03:42:43 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pppd oopses current linu's git tree on disconnect
Message-Id: <20060123034243.22ba0a8f.diegocg@gmail.com>
In-Reply-To: <43D01537.40705@microgate.com>
References: <20060119010601.f259bb32.diegocg@gmail.com>
	<1137692039.3279.1.camel@amdx2.microgate.com>
	<20060119230746.ea78fcf4.diegocg@gmail.com>
	<43D01537.40705@microgate.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 19 Jan 2006 16:39:51 -0600,
Paul Fulghum <paulkf@microgate.com> escribió:


> The chances of this happening increase with the speed and
> continued use of the serial port. Your original report showed
> a lengthy PPP session. So bringing the link down and up without
> significant data transfer will probably not trigger this.


Ok - I seem to be able to reproduce it in a unpatched kernel using
a lengthy session. I will try your patch and report back.
