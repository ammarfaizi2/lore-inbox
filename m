Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVCXTSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVCXTSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVCXTSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:18:46 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:62084 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261739AbVCXTSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:18:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EEYHd9r3SlDyWd6dUWrpHQbmK6nWxdGLK3tqqyHY2pss9Lc+f0WdgBXFcn8hZmkwRcgmoTnaURk2nh3jYCBY6cMeUKRo+VuaUFnRbYPGH7GOjhsK7un39D6O6tEkIyHCjn30kuRkfF+QKmo9kreAY8n5y938KQNNREZ4ttTZ1S4=
Message-ID: <d120d500050324111826335f67@mail.gmail.com>
Date: Thu, 24 Mar 2005 14:18:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050324181059.GA18490@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
	 <20050324181059.GA18490@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 10:10:59 -0800, Andy Isaacson <adi@hexapodia.org> wrote:
> 
> So I added i8042.noaux to my kernel command line, rebooted, insmodded
> intel_agp, started X, and verified no touchpad action.  Then I
> suspended, and it worked fine.  After restart, I suspended again - also
> fine.
> 
> So I think that fixed it.  But no touchpad is a bit annoying. :)
> 

Try adding i8042.nomux instead of i8042.noaux, it should keep your
touchpad in working condition. Please let me know if it still wiorks.

-- 
Dmitry
