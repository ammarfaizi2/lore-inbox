Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTELOou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTELOou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:44:50 -0400
Received: from gate.in-addr.de ([212.8.193.158]:446 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262179AbTELOot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:44:49 -0400
Date: Mon, 12 May 2003 16:56:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Clemens Schwaighofer <cs@tequila.co.jp>,
       Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Two RAID1 mirrors are faster than three
Message-ID: <20030512145624.GZ10519@marowsky-bree.de>
References: <200305112212_MC3-1-386B-32BF@compuserve.com> <3EBF24A8.1050100@tequila.co.jp> <1052716203.4100.10.camel@tor.trudheim.com> <3EBF5DF2.2080204@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EBF5DF2.2080204@tequila.co.jp>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-05-12T17:40:18,
   Clemens Schwaighofer <cs@tequila.co.jp> said:

> that sounds like a super special featuer never needed in Software (!!)
> Raid thing (IMvHO).

No.

3way mirroring is actually rather useful. You can take a failure and
_still_ be fully redundant (ie, like a hot-spare, just already synced).
In theory, you could even read from three drives and correct errors on
one drive.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
