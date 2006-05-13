Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWEMWhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWEMWhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWEMWhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 18:37:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48096 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932388AbWEMWhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 18:37:43 -0400
Date: Sat, 13 May 2006 23:37:30 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: device-mapper development <dm-devel@redhat.com>
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might be dm related)
Message-ID: <20060513223730.GT16180@agk.surrey.redhat.com>
Mail-Followup-To: device-mapper development <dm-devel@redhat.com>,
	"Steinar H. Gunderson" <sgunderson@bigfoot.com>,
	linux-kernel@vger.kernel.org
References: <20060426204809.GA15462@uio.no> <20060426135809.10a37ec3.akpm@osdl.org> <20060513134908.GA4480@uio.no> <20060513073344.4fcbc46b.akpm@osdl.org> <20060513144334.GA6013@uio.no> <20060513075147.423d18bd.akpm@osdl.org> <20060513150003.GA6096@uio.no> <20060513082409.4d173ccc.akpm@osdl.org> <20060513153231.GA6277@uio.no> <20060513084317.50356155.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513084317.50356155.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the device configuration here:
   e.g. linear dm logical volume over md raid5?

[e.g. post output of dmsetup info -c' and 'dmsetup table'
and 'dmsetup status' remembering to blank out the
long hex string if you have dm-crypt]

Alasdair
-- 
agk@redhat.com
