Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUH3Us1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUH3Us1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUH3Us1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:48:27 -0400
Received: from holomorphy.com ([207.189.100.168]:21175 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261232AbUH3UsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:48:21 -0400
Date: Mon, 30 Aug 2004 13:48:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040830204814.GG5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paulo Marques <pmarques@grupopie.com>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Andries Brouwer <aeb@cwi.nl>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <4133718D.60002@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4133718D.60002@grupopie.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Well, since I couldn't stop vomiting for hours after I looked at the
>> code for readprofile(1), here's a reimplementation, with various
>> misfeatures removed, included as a MIME attachment.

On Mon, Aug 30, 2004 at 07:27:25PM +0100, Paulo Marques wrote:
> While you're at it, can readprofile work by reading the symbols from 
> /proc/kallsyms?
> If it can, this could be added to the list of files that it tries to 
> open, so that it could work even if System.map wasn't available.

Well, if it can accept input from a pipe, there's no real need. Since
it would need to be sorted, it would probably bloat the utility too
much to do it internally by creating redundancy with sort(1).


-- wli
