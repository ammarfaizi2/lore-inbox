Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265451AbTF1Us7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbTF1Us6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:48:58 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:5124 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S265451AbTF1Usw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:48:52 -0400
Subject: 2.4.21 use propper type for pid -I
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jun 2003 23:03:08 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19WMqi-000CrY-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
here are a bunch of cleanup patches. they dont fix a real problem they
simply clean the use of pid. pid should be of type pid_t to allow different
architectures a different choise (and they do). In programms we found the
use from signed to unsigned and from int to long. So daniele bellucci and i
wrote to a several maintainers for cleanup i am happy to see that several
patches got applied.                                          

greetings
walter

-- 
