Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbTCMLqX>; Thu, 13 Mar 2003 06:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbTCMLqX>; Thu, 13 Mar 2003 06:46:23 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:4110 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S262243AbTCMLqW>;
	Thu, 13 Mar 2003 06:46:22 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NetFlow export
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2003 12:57:08 +0100
In-Reply-To: <20030313114809.GA29730@unthought.net> (Jakob Oestergaard's
 message of "Thu, 13 Mar 2003 12:48:09 +0100")
Message-ID: <87znnz8oob.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <87adfza5kb.fsf@deneb.enyo.de>
	<20030313114809.GA29730@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard <jakob@unthought.net> writes:

> On Thu, Mar 13, 2003 at 12:07:00PM +0100, Florian Weimer wrote:
>> Are there any patches which implement kernel-based NetFlow data
>> export?
>
> Netramet works very well - it's userspace (and very flexible indeed).

According to the documentation, it can receive NetFlow data and
process it, but it cannot generate such data.

> No need to clutter the kernel with an SNMP stack too, if you ask me.

NetFlow doesn't use a complicated packet format and is not based on
SNMP.  You can parse version 5 or 7 packets in 10 lines of Perl code,
using a few calls to "unpack".
