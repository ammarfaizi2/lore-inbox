Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUGPKQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUGPKQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 06:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUGPKQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 06:16:45 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:20490 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266513AbUGPKQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 06:16:44 -0400
Date: Fri, 16 Jul 2004 12:17:21 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Which is the purpose of the inode field in a TCP socket?
Message-ID: <20040716101721.GA23823@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I mean, the field 'i_ino' in the 'struct inode' field contained
in the 'struct socket' field of the 'struct tcp_opt' structure, shown
as field number 10 in each entry of /proc/net/tcp. Moreover, this
inode number doesn't seem to be associated with any block device,
maybe is a fake inode number?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
