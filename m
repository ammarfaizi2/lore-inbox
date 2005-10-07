Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVJGGt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVJGGt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 02:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVJGGt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 02:49:56 -0400
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:27577 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751246AbVJGGt4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 02:49:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Date: Fri, 7 Oct 2005 01:49:53 -0500
User-Agent: KMail/1.8.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
References: <20050915070131.813650000.dtor_core@ameritech.net> <200510062258.07793.dtor_core@ameritech.net> <20051007064144.GA7992@ftp.linux.org.uk>
In-Reply-To: <20051007064144.GA7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510070149.53918.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 October 2005 01:41, Al Viro wrote:
> ... when the first one to fix should be the lifetime rules.  Both sysfs
> stuff and locking depend on those...

FWIW for me it is easier to think about lifetime rules when I already have
sysfs support. I mean sysfs itself dictates basic lifetime rules, additional
constraints are just that - additional constraints.

-- 
Dmitry
