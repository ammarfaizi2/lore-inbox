Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbTKNVCC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTKNVCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:02:02 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:45444 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S264588AbTKNVCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:02:00 -0500
Date: Fri, 14 Nov 2003 21:01:58 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: Harald Welte <laforge@netfilter.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031114204212.GK6937@obroa-skai.de.gnumonks.org>
Message-ID: <Pine.LNX.4.44.0311142059560.849-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003, Harald Welte wrote:
> The problem is, that seq_file is already using the file.private_data
> member...

there is a seq_file->private pointer where you can store private (per file 
structure) data. That is what I do and it works very nice, BUT the problem 
is that the ->private pointer was only added to seq_file recently 
(2.4.20 if I remember correctly) although seq_file API was present since 
2.4.15.

Kind regards
Tigran

