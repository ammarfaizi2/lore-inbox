Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbUKQOT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUKQOT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUKQOT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:19:56 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:58219 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262325AbUKQOTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:19:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=P0yVWYynKI3L8xOzysBFj/vsoZRh/5DtI1AzS7VmQY5VRCycDJQmO+0JN8QrRPsDmfnH1BhA3pybaxnyhiWbMBXPTSeRDA9IPJ1s+1sNuw8PiCfxUhjdI9OTMsmmRBgnIJK+Vp2vLmhsubK4uZUhZt7R7uoZYwrxSORJQ46sL7E=
Message-ID: <d120d500041117061998c310b@mail.gmail.com>
Date: Wed, 17 Nov 2004 09:19:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Subject: Re: [patch] prefer TSC over PM Timer
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
	 <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 17:50:42 -0800 (PST), dean gaudet
<dean-list-linux-kernel@arctic.org> wrote:
> on a tangent... has the local apic timer ever been considered?  it's fixed
> rate, and my measurements show it in the same performance ballpark as TSC.
> 

At least Dell laptops will die horrible death if you enable lapic,
probably others.

-- 
Dmitry
