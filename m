Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWGCNoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWGCNoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGCNoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:44:44 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:10847 "EHLO
	asav02.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750794AbWGCNon convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:44:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAP+7qESBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [RFC] Apple Motion Sensor driver
Date: Mon, 3 Jul 2006 09:44:40 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch,
       benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net,
       chainsaw@gentoo.org
References: <20060702222649.GA13411@hansmi.ch>
In-Reply-To: <20060702222649.GA13411@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607030944.41330.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 July 2006 18:26, Michael Hanselmann wrote:
> +       set_bit(EV_ABS, ams.idev->evbit);
> +       set_bit(EV_KEY, ams.idev->evbit);
> +       set_bit(BTN_TOUCH, ams.idev->keybit);

BTW, what is BTN_TOUCH doing here? I don't see it being reported anywhere...

Just drop it off and have ams be a "joystick" instead of a "mouse" ;)
Joystick interface is probably better suited anyway.

-- 
Dmitry
