Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUDWTl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUDWTl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUDWTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:41:25 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:59910 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S261162AbUDWTlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:41:24 -0400
Message-ID: <4089723A.9090401@mauve.plus.com>
Date: Fri, 23 Apr 2004 20:44:58 +0100
From: Ian Stirling <linux-kernel@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ITE8212 - SMART with RAID card.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ITE raid card, that I bought to add more than 4 ide devices to
my server, as it was available from a supplier that I was ordering other
stuff from at the time, but vanilla IDE cards were not.

The card has source available from the maker,
http://www.ite.com.tw/pc/LinuxSrc_it8212_v1.44.zip

Which basically makes the drives act as SCSI ones.

Annoyingly, it does not seem to support DVD/CD drives, as these are not
detected in the cards BIOS, or by the driver. (I had planned to put a couple of
CD drives and a DVD on it.)

And SMART and other IDE specific tools do not work.
This is a pity, as I like to run home-rolled scripts to track SMART status,
monitor temperatures/...

Is there any "dumb" driver that simply presents the drives as hde-hdh?
