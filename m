Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTEMOE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbTEMOE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:04:58 -0400
Received: from pointblue.com.pl ([62.89.73.6]:25615 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261270AbTEMOE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:04:57 -0400
Subject: Re: [COMPILATION ERROR] 2.5.69-bk7 wireless.c:488: `THIS_MODULE'
	undeclared here
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1052834757.2268.13.camel@nalesnik>
References: <1052834757.2268.13.camel@nalesnik>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1052835040.2227.18.camel@nalesnik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 May 2003 15:10:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 15:06, Grzegorz Jaskiewicz wrote:
> net/core/wireless.c:488: `THIS_MODULE' undeclared here (not in a
> function)
> 
> this bug was added with -bk7 patch
solved : looks like #include <linux/modules.h> was missing in this file
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

