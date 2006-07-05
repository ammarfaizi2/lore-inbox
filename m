Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWGEDNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWGEDNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 23:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGEDNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 23:13:36 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:50785 "EHLO
	asav06.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S932252AbWGEDNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 23:13:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAP7IqkSBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Shem Multinymous <multinymous@gmail.com>
Subject: Re: [Hdaps-devel] Generic interface for accelerometers (AMS, HDAPS, ...)
Date: Tue, 4 Jul 2006 23:13:22 -0400
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Henrique de Moraes Holschuh <hmh@debian.org>,
       Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607042313.27627.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 06:26, Shem Multinymous wrote:
> 
> BTW, can the driver tell when nothing is accessing its input device,
> and avoid polling in that case?
> 

Yes (->open is called when there is a client opening one of the input
interfaces), but I don't think that "oh shit I dropped my laptop" events
belong to input layer.

-- 
Dmitry
