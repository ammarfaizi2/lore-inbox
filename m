Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277677AbRJRKTQ>; Thu, 18 Oct 2001 06:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277686AbRJRKS5>; Thu, 18 Oct 2001 06:18:57 -0400
Received: from [195.66.192.167] ([195.66.192.167]:47884 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S277677AbRJRKSs>; Thu, 18 Oct 2001 06:18:48 -0400
Date: Thu, 18 Oct 2001 13:18:46 +0200
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <892518120.20011018131846@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
CC: Wojtek Pilorz <wpilorz@bdk.pl>
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <Pine.LNX.4.21.0110181141040.9091-100000@celebris.bdk.pl>
In-Reply-To: <Pine.LNX.4.21.0110181141040.9091-100000@celebris.bdk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thursday, October 18, 2001, 11:55:41 AM,
Wojtek Pilorz <wpilorz@bdk.pl> wrote:

>> > > Be very careful not to modify a multi-linked file, or
>> > > it will be damaged in all trees and won't be seen by

WP> To be sure it is not possible to modify original tree files, I do
WP> chown -R root.root original_tree

WP> before copying it (via cp -lR) to new one, which will be modified with
WP> whatever tools by me, logged in as a regular user. For those having root
WP> access to a box this might be a useful way of preventing accidents ...
WP> (this of course also assumes sane file permissions)
WP> [...]

Everytime I see this 'hardlinked kernel tree' technique explained,
I think about true COW fs where duplicate files are physically the
same single file but users don't care about that - COW magic...
No hardlink/vi/emacs/... tricks will be needed...
-- 
Best regards, vda
mailto:vda@port.imtp.ilyichevsk.odessa.ua


