Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTHFNfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTHFNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:35:30 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:18129 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S261151AbTHFNf2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:35:28 -0400
Message-Id: <200308061333.h76DX2dc013593@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: herbert@13thfloor.at
CC: Olaf Titz <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
Subject: RE: chroot() breaks syslog() ?
Date: Wed, 6 Aug 2003 15:34:33 +0200
Organization: Linux Kernel Austria
X-Mailer: Oracle Outlook Connector 3.4 40812
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Pötzl <herbert@13thfloor.at> wrote:
[ ... ]
> hmm, how will you avoid creation of special (devicenodes)
> files if I have raw access to any partition? I can 'simply'
> use xxd to create my special inodes on the medium ...
> and I would not care if mount is enabled or not when I
> wipe the root partition with dd ...

AFAIK, there are possibilities to deny _RAW_ access to partitions, while in a chroot-jail... If not, I'll tell the grsec-team to implement a new feature. :)

Best regards,
 Oliver

