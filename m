Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTDYIiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 04:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTDYIiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 04:38:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:51726 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263373AbTDYIiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 04:38:07 -0400
Message-ID: <3EA8F748.5060108@aitel.hist.no>
Date: Fri, 25 Apr 2003 10:52:24 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Flame Linus to a crisp!
References: <200304250702.h3P72FZF000352@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

> Could we not take this idea to it's logical extreme, and simply
> calculate the results of every opcode, on every value, for every state
> of all of the registers, and store them in an array of DIMMs, and
> simply look up the necessary results?  I.E. a cpu which is one _huge_
> look up table :-).

You can, if you can keep the internal state sufficiently small.
Say we want to keep the internal state down to 32 bit,
using a 16GB lookup table. (4G*32bit)

What would the state be?  Perhaps one general-purpose
8-bit register, a 16-bit program counter and
8 bits left for the current opcode & flags.

Less opportunities than a 6502, but it'd sure be fast.

Helge Hafting


