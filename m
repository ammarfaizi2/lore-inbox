Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVBGTEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVBGTEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBGTBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:01:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:51087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261233AbVBGTAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:00:36 -0500
Date: Mon, 7 Feb 2005 11:00:42 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-net@vger.kernel.org, lartc@mailman.ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 - 2.6.10-050207
Message-ID: <20050207110042.166752a3@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update to iproute2 utilities, mostly bug fixes. Only new functionality is
integration of the ability to derive netem distribution table from experimental
data; simple port from NISTnet.

Download from http://developer.osdl.org/dev/iproute2/download/iproute2-050207.tar.gz

[Mads Martin Joergensen]
	Don't mix address families when flushing	

[Jean-Marc Ranger]
	Need to call getline() with null for first usage
	Don't overwrite const arg

[Stephen Hemminger]
	Add experimental distribution
	Validate classid is not too large to cause loss of bits.

-- 
Stephen Hemminger	<shemminger@osdl.org>
