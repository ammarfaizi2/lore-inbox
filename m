Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbTIXQaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbTIXQaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:30:08 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:49348
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261495AbTIXQaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:30:06 -0400
Date: Wed, 24 Sep 2003 12:35:05 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: John Bradford <john@grabjohn.com>, rjohnson@analogic.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Horiffic SPAM
Message-ID: <20030924123505.A1023@animx.eu.org>
References: <200309241508.h8OF8ISB002016@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0309240920560.6757@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.58.0309240920560.6757@dlang.diginsite.com>; from David Lang on Wed, Sep 24, 2003 at 09:21:49AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if you want to block mail you need to have your MTA return a 500 series
> error code when it gets a connection from that IP address, otherwise the
> sending MTA will just retry later, resulting in the problem described.

Adendum: 5xx error code for each RCPT command.  Otherwise, some MTAs will
treat 5xx as 4xx.

I've been hit enough with this virus that I've blocked everyone except lkml
and exim lists (by IP) from this server (my backup will accept however and is
on a quicker line)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
