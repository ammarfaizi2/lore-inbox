Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVCVCvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVCVCvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVCVCsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:48:33 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:48269 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262556AbVCVCrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:47:40 -0500
Date: Tue, 22 Mar 2005 03:51:04 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Magnus Damm <damm@opensource.se>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20050322025104.GA18067@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
References: <20050321154226.19053.36781.35540@clementine.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321154226.19053.36781.35540@clementine.local>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: Re: [PATCH] dvb_frontend: MODULE_PARM_DESC
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 05:10:27PM +0100, Magnus Damm wrote:
> Remove "dvb_"-prefix from parameters. Without the patch all parameters except
> the declaration of parameter "frontend_debug" have a "dvb_"-prefix.

Why is that dvb_ prefix a problem?

> Error detected with section2text.rb, see autoparam patch.

Please only fix errors and do not rename other parameters. We shouldn't
break users' modprobe.conf option settings.

Johannes
