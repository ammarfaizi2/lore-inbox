Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUEHSwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUEHSwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUEHSwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:52:40 -0400
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:9740 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S264095AbUEHSwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:52:38 -0400
Date: Sat, 8 May 2004 20:52:29 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64 and RAID6
Message-ID: <20040508185229.GA869@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <409D1D86.6050907@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409D1D86.6050907@clanhk.org>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Ryan Earl <heretic@clanhk.org>
Date: Sat, May 08, 2004 at 12:48:54PM -0500
> Why doesn't RAID6 use the int64x4 algorithm in this situation?  What is 
> the motivation of setting the 'prefer field' on the sse algorithms and 
> not on the integer based algorithms?
> 
IIRC, the sse variants have better cache-behaviour, and are thus almost
always selected.

Try googling for exact answers, this has come up before.

HTH,
Jurriaan
-- 
Spock: "Logic, logic, logic...  Logic is the beginning of wisdom,
Valeris, not  the end."
"STVI:TUC", Stardate 9522.6
Debian (Unstable) GNU/Linux 2.6.6-rc3-mm1 2x6062 bogomips 0.06 0.16
