Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWBPNNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWBPNNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 08:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWBPNNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 08:13:11 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:4576 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1160999AbWBPNNK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 08:13:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=fG2hnvTf3H2ZWiF8PYorlaiA5jME6YvmheKT1TsZueDPeiHvFiNbUtcUX0yzqaRO1cR0hR2RRi8so4QeJ9Buyw1KrMpWa0r1bkFfg9BthHpFZamuYTZ0FDvei9p3iEWBrf7zmgcRfQ4zaaxu6QlWjCQJBik+DKwaPLcPkbnwl5Y=
Date: Thu, 16 Feb 2006 14:11:32 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: airlied@gmail.com, linux-kernel@vger.kernel.org, davej@redhat.com,
       dri-devel@lists.sourceforge.net
Subject: Re: IRQ disabled (i915?) when switchig between gnome themes
 (gnome-theme-manager)
Message-Id: <20060216141132.3dd4ce0b.diegocg@gmail.com>
In-Reply-To: <20060216115208.GA30437@isilmar.linta.de>
References: <20060130203809.GA8098@dominikbrodowski.de>
	<21d7e9970602132255l5a7ff5feqa82ccad2c90ac4d8@mail.gmail.com>
	<20060216115208.GA30437@isilmar.linta.de>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 16 Feb 2006 12:52:08 +0100,
Dominik Brodowski <linux@dominikbrodowski.net> escribió:

> On Tue, Feb 14, 2006 at 05:55:16PM +1100, Dave Airlie wrote:
> > Can you try the patch at
> > http://www.skynet.ie/~airlied/patches/dri/i915_irq_stop.diff


Could this fix this http://bugzilla.kernel.org/show_bug.cgi?id=6082 ?
(reported today)
