Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbQLQPFm>; Sun, 17 Dec 2000 10:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132666AbQLQPFd>; Sun, 17 Dec 2000 10:05:33 -0500
Received: from gate.in-addr.de ([212.8.193.158]:56330 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S131495AbQLQPFZ>;
	Sun, 17 Dec 2000 10:05:25 -0500
Date: Sun, 17 Dec 2000 15:34:53 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Monitoring filesystems / blockdevice for errors
Message-ID: <20001217153453.O5323@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

currently, there is no way for an external application to monitor whether a
filesystem or underlaying block device has hit an error condition - internal
inconsistency, read or write error, whatever.

Short of parsing syslog messages, which isn't particularly great.

This is necessary for server monitoring in general.

I don't have a real idea how this could be added, short of adding a field to
/proc/partitions (error count) or something similiar.

Comments?

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
