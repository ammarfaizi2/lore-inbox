Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272404AbTHGMEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHGMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:04:05 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:54697 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S272404AbTHGMEB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:04:01 -0400
Message-Id: <200308071201.h77C1WEP007411@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: herbert@13thfloor.at, linux-kernel@vger.kernel.org
Subject: grsec chroot; deny raw access (WAS: RE: chroot() breaks syslog() ?)
Date: Thu, 7 Aug 2003 14:02:58 +0200
Organization: Linux Kernel Austria
X-Mailer: Oracle Outlook Connector 3.4 40812
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Pitzeier wrote <oliver@linux-kernel.at> wrote:
> Herbert Pötzl <herbert@13thfloor.at> wrote:
> [ ... ]
> > hmm, how will you avoid creation of special (devicenodes) 
> > files if I have raw access to any partition? I can 'simply'
> > use xxd to create my special inodes on the medium ... and I
> > would not care if mount is enabled or not when I wipe the
> > root partition with dd ...
> 
> AFAIK, there are possibilities to deny _RAW_ access to 
> partitions, while in a chroot-jail... If not, I'll tell the 
> grsec-team to implement a new feature. :)

I had contact to one of the grsec folks. He told me that it IS
possible, if you have enabled the ACL system...

The original mail he sent me was:

> I noticed your lkml post.  grsecurity will indeed deny raw
> access to block devices in a chroot, but only if the ACL
> system is enabled.

Herbert, I hope that helps? :)

Best regards,
 Oliver

