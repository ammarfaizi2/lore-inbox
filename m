Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUAIOPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUAIOPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:15:00 -0500
Received: from macvin.cri2000.ens-lyon.fr ([140.77.13.138]:33484 "EHLO macvin")
	by vger.kernel.org with ESMTP id S261613AbUAIOO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:14:57 -0500
Date: Fri, 9 Jan 2004 15:14:55 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 make menuconfig error
Message-ID: <20040109141455.GJ4485@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux 2.6.0 i686
Organization: Ecole Normale Superieure de Lyon
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When configuring 2.6.1 with make menuconfig,
if I choose not to save my configuration changes,
I get this error:


puligny:~/build/linux-2.6.1% make menuconfig
make[1]: scripts/fixdep' is up to date.
scripts/kconfig/mconf arch/i386/Kconfig
#
# using defaults found in .config
#


Your kernel configuration changes were NOT saved.

make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2
puligny:~/build/linux-2.6.1%


2.6.0 does not show such two error lines.

Best regards.
-- 
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-INRIA-ENS Lyon
France
