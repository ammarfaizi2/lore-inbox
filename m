Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbREQDDa>; Wed, 16 May 2001 23:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbREQDDK>; Wed, 16 May 2001 23:03:10 -0400
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:4356 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S261366AbREQDDB>;
	Wed, 16 May 2001 23:03:01 -0400
Date: Wed, 16 May 2001 23:03:12 -0400
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: write() writes too many bytes?
Message-ID: <20010516230312.A187@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I know this is bizarre and probably some goof on my part, but it
is just too weird for me to guess at further:

My program write()s 2- and 4- byte chunks or data to a file (for a WAV
header). When the data being written contains an 0xff byte, it is
apparently written to disk as 2 bytes: 0x81ff.

