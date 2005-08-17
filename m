Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVHQQks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVHQQks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 12:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVHQQks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 12:40:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62100 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751159AbVHQQks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 12:40:48 -0400
Subject: Re: [rfc][patch] API for timer hooks
From: Lee Revell <rlrevell@joe-job.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <430363F2.7090009@aknet.ru>
References: <42FDF744.2070205@aknet.ru>
	 <1124126354.8630.3.camel@cog.beaverton.ibm.com> <43024ADA.8030508@aknet.ru>
	 <1124244580.30036.5.camel@mindpipe>  <430363F2.7090009@aknet.ru>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 12:40:43 -0400
Message-Id: <1124296844.3591.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 20:21 +0400, Stas Sergeev wrote:
> perhaps allowing a single higher frequency, or allowing just any
> frequency, is pretty much the same task, and doesn't
> look achievable within the currently existing
> timer API anyway

Lots of things aren't doable with the current timer API, hence all the
recent work on dynamic tick.  This driver would actually be a perfect
test for the dynamic tick system as your PC speaker driver basically
implements its own dynamic tick mechanism.  Just replace all the PIT
reprogramming with itimers.

Lee 
 

