Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTK0QL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbTK0QL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:11:58 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:32654 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S264555AbTK0QL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:11:57 -0500
Date: Thu, 27 Nov 2003 17:11:43 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Selecting CPU frequency on Asus P4M laptop
Message-ID: <20031127161143.GA10634@localhost>
References: <yw1x65h5ddbn.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x65h5ddbn.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 27th 2003 Måns Rullgård wrote:

> Is there any way to change which of these will be used after booting?

Have you already tried (as a module, *not* builtin) the SpeedStep
clockmod driver (CONFIG_X86_P4_CLOCKMOD=M) or, if your Southbridge is an
ICH[234], the ICH driver (CONFIG_X86_SPEEDSTEP_ICH=M)?

You might then always have access to the maximum speed, and reduce
according to need of usage to something lower.
-- 
Marco Roeland
