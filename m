Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWAXJXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWAXJXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWAXJXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:23:51 -0500
Received: from gate.in-addr.de ([212.8.193.158]:31198 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1030427AbWAXJXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:23:50 -0500
Date: Tue, 24 Jan 2006 10:23:03 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 7] md: Introduction - raid5 reshape mark-2
Message-ID: <20060124092303.GD22870@marowsky-bree.de>
References: <20060124112626.4447.patches@notabene>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060124112626.4447.patches@notabene>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-24T11:40:47, NeilBrown <neilb@suse.de> wrote:

> I am expecting that I will ultimately support online conversion of
> raid5 to raid6 with only one extra device.  This process is not
> (efficiently) checkpointable and so will be at-your-risk.

So the best way to go about that, if one wants to keep that option open
w/o that risk, would be to not create a raid5 in the first place, but a
raid6 with one disk missing?

Maybe even have mdadm default to that - as long as just one parity disk
is missing, no slowdown should happen, right?


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

