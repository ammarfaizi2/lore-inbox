Return-Path: <linux-kernel-owner+w=401wt.eu-S1425554AbWLHPWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425554AbWLHPWv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425558AbWLHPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:22:50 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:61711 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425554AbWLHPWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:22:48 -0500
Date: Fri, 8 Dec 2006 16:22:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061208152242.GD15860@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 Documentation/s390/driver-model.txt |    7 +
 arch/s390/Kconfig                   |   14 +-
 arch/s390/defconfig                 |    1 -
 arch/s390/kernel/setup.c            |   55 +----
 arch/s390/lib/uaccess_pt.c          |    5 +-
 arch/s390/mm/Makefile               |    2 +-
 arch/s390/mm/extmem.c               |  106 ++------
 arch/s390/mm/init.c                 |  184 ++++-----------
 arch/s390/mm/vmem.c                 |  381 +++++++++++++++++++++++++++++
 drivers/s390/block/dasd.c           |    8 +-
 drivers/s390/block/dasd_3990_erp.c  |   23 +-
 drivers/s390/block/dasd_devmap.c    |   49 ++++
 drivers/s390/block/dasd_int.h       |    4 -
 drivers/s390/char/ctrlchar.c        |    9 +-
 drivers/s390/char/tape.h            |    3 +-
 drivers/s390/char/tape_34xx.c       |   23 +-
 drivers/s390/char/tape_3590.c       |    7 +-
 drivers/s390/char/tape_block.c      |   14 +-
 drivers/s390/char/tape_core.c       |   14 +-
 drivers/s390/cio/chsc.c             |   28 +-
 drivers/s390/cio/cio.c              |   62 ++++--
 drivers/s390/cio/cio.h              |    6 +-
 drivers/s390/cio/css.c              |   69 ++++--
 drivers/s390/cio/css.h              |    9 +
 drivers/s390/cio/device.c           |  456 ++++++++++++++++++++++++++---------
 drivers/s390/cio/device.h           |    6 +-
 drivers/s390/cio/device_fsm.c       |   58 +++--
 drivers/s390/cio/device_ops.c       |   28 +-
 drivers/s390/cio/qdio.c             |  234 ++++++++++--------
 drivers/s390/cio/qdio.h             |   28 +--
 drivers/s390/crypto/ap_bus.c        |   17 ++
 include/asm-s390/dasd.h             |    2 +
 include/asm-s390/page.h             |   22 ++-
 include/asm-s390/pgalloc.h          |    3 +
 include/asm-s390/pgtable.h          |   16 +-
 35 files changed, 1298 insertions(+), 655 deletions(-)
 create mode 100644 arch/s390/mm/vmem.c

Andrew Morton (1):
      [S390] workqueue fixes.

Cornelia Huck (5):
      [S390] Some preparations for the dynamic subchannel mapping patch.
      [S390] subchannel lock conversion.
      [S390] Support for disconnected devices reappearing on another subchannel.
      [S390] Use dev->groups for adding/removing the subchannel attribute group.
      [S390] Update documentation for dynamic subchannel mapping.

Heiko Carstens (4):
      [S390] uaccess_pt: add missing down_read() and convert to is_init().
      [S390] Virtual memmap for s390.
      [S390] Use add_active_range() and free_area_init_nodes().
      [S390] Poison init section before freeing it.

Horst Hummel (1):
      [S390] New DASD feature for ERP related logging

Martin Schwidefsky (1):
      [S390] more workqueue fixes.

Ralph Wuerthner (1):
      [S390] add reset call handler to the ap bus.

Ursula Braun (1):
      [S390] runtime switch for qdio performance statistics

diff is larger than 100K. Skipped.

