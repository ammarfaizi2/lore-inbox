Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269615AbRHHXHV>; Wed, 8 Aug 2001 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269619AbRHHXHL>; Wed, 8 Aug 2001 19:07:11 -0400
Received: from zero.tech9.net ([209.61.188.187]:13063 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S269615AbRHHXGw>;
	Wed, 8 Aug 2001 19:06:52 -0400
Subject: Re: Linux 2.4.7-ac10
From: Robert Love <rml@tech9.net>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010808195133.A22469@lightning.swansea.linux.org.uk>
In-Reply-To: <20010808195133.A22469@lightning.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 08 Aug 2001 19:07:24 -0400
Message-Id: <997312050.2170.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Aug 2001 19:51:34 +0100, Alan Cox wrote:
> 2.4.7-ac10
> o	Merge DRM for XFree 4.1.x			(XFree86 and others)

the config tri-states for the new DRM drivers are screwed.  you can not
select any of the individual graphics drivers if the `New 4.1 DRM'
option is selected.

when saving the config, `make xconfig' spits

ERROR - Attempting to write value for unconfigured variable
(CONFIG_DRM_TDFX)

etc for CONFIG_DRM_GAMMA, CONFIG_DRM_R128, CONFIG_DRM_RADEON,
CONFIG_DRM_I810, and CONFIG_DRM_MGA

btw, its nice to see the 4.1 DRM support in your tree.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

