Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUKTKdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUKTKdX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKTKcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:32:17 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:46861 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261551AbUKTKcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:32:11 -0500
Date: Sat, 20 Nov 2004 11:32:10 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Justin Thiessen <jthiessen@penguincomputing.com>, Greg KH <greg@kroah.com>,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
Message-Id: <20041120113210.40e194fb.khali@linux-fr.org>
In-Reply-To: <1100945635.2639.31.camel@laptop.fenrus.org>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
	<20041118185612.GA20728@penguincomputing.com>
	<1100945635.2639.31.camel@laptop.fenrus.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

> > static ssize_t show_in(struct device *dev, char *buf, int nr)
> > {
> > 	struct adm1026_data *data = adm1026_update_device(dev);
> > 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
> > }
> 
> any chance you could make this use snprintf instead ?

None of the other hardware monitoring clients driver do, nor do I think
they should. What are we trying to improve?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
