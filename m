Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTIOLex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTIOLex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:34:53 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:22970 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S261305AbTIOLew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:34:52 -0400
Date: Mon, 15 Sep 2003 13:34:46 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-t4/5] Error inserting module snd
Message-ID: <20030915113446.GF1091@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Stefano Rivoir <s.rivoir@gts.it>,
	linux-kernel@vger.kernel.org
References: <3F65A230.3020806@gts.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F65A230.3020806@gts.it>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir, Mon, Sep 15, 2003 13:27:44 +0200:
> When inserting module snd, modprobe bails out saying
> 
> snd: Unknown parameter 'device_mode'

remove the parameter (device_mode). It could be in modprobe.conf, or in
your modprobe command line. There could be possibly others, obsoleted
parameters, so be prepared to remove more.


