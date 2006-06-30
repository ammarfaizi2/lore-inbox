Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbWF3QVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWF3QVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWF3QVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:21:31 -0400
Received: from outbound-mail-45.bluehost.com ([70.96.188.14]:59339 "HELO
	outbound-mail-45.bluehost.com") by vger.kernel.org with SMTP
	id S932763AbWF3QVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:21:31 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Robert Nagy" <robert.nagy@gmail.com>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Date: Fri, 30 Jun 2006 09:21:24 -0700
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <39f633820606290818g1978866ap@mail.gmail.com> <200606300906.47077.jbarnes@virtuousgeek.org> <39f633820606300914i170c9a25i24e834efc36703f5@mail.gmail.com>
In-Reply-To: <39f633820606300914i170c9a25i24e834efc36703f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606300921.24909.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 30, 2006 9:14 am, Robert Nagy wrote:
> no i do not have kdb. and i cannot even boot the box now. is there any
> way to disable the megaraid driver with an argument?

Not that I know of.  But you can use your system controller to disable 
the PCI slot containing the RAID card... that should let you boot.  I 
don't remember what the command is, but you can type 'help' at your L1 
or L2 prompt.

Jesse
