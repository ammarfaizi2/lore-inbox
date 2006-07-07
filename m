Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWGGCLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWGGCLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGGCLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:11:12 -0400
Received: from mail.tmr.com ([64.65.253.246]:31404 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751061AbWGGCLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:11:11 -0400
Message-ID: <44ADC3CE.1030302@tmr.com>
Date: Thu, 06 Jul 2006 22:15:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com> <1152189796.5689.17.camel@lade.trondhjem.org>
In-Reply-To: <1152189796.5689.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>Nobody gives a rats arse about backups: those are infrequent and
>can/should use more sophisticated techniques such as checksumming.
>
Actually, those of us who do run production servers care vastly about 
backups. And beside being utterly unscalable (checksum 20 TB of files 
four times a day to find what changed???), you would have to remember 
the checksums for all those files.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

