Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbTCTS4E>; Thu, 20 Mar 2003 13:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTCTS4E>; Thu, 20 Mar 2003 13:56:04 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:12965 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261461AbTCTS4D>; Thu, 20 Mar 2003 13:56:03 -0500
Date: Thu, 20 Mar 2003 19:06:53 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz
Subject: Re: CPU misdetection and, (probably unrelated) IDE data corruption
Message-ID: <20030320190648.GB21382@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	vojtech@ucw.cz
References: <200303201452.h2KEqNFF000415@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303201452.h2KEqNFF000415@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 02:52:22PM +0000, John Bradford wrote:

 > * Misdetection of an Athlon 1700XP as a Duron
 > model name      : AMD Duron(tm) Processor

This string is set by the BIOS at power-on time.
If it really is an Athlon, your BIOS is horked.
Try upgrading it.

Out of curiosity, what does x86info[1] make of it ?

		Dave

[1] See http://www.codemonkey.org.uk/cvs/ for a snapshot.

