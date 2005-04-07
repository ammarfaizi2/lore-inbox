Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVDGMin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVDGMin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVDGMim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:38:42 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:58009 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262447AbVDGMil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:38:41 -0400
Message-ID: <42552A33.6070704@ext.bull.net>
Date: Thu, 07 Apr 2005 14:40:19 +0200
From: Patrice Martinez <patrice.martinez@ext.bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "Philippe Garrigues (openX2)" <garrigue@openx2.frec.bull.fr>
Subject: /dev/random problem on 2.6.12-rc1
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/04/2005 14:48:24,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/04/2005 14:48:26,
	Serialize complete at 07/04/2005 14:48:26
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When  using a machine with a  2612-rc 1kernel, I encounter problems 
reading /dev/random:
 it simply nevers returns anything, and the process is blocked in the 
read...
The easiest way to see it is to type:
 od < /dev/random

Any idea?

-- 

Best regards

Patrice Martinez

Linux Kernel Architect.

OFFICE : B1-405
PHONE  : +33 (0)4 76 29 74 69
EMAIL  : Patrice.martinez@ext.bull.net
ADDR   : BULL, 1 rue de Provence, BP 208, 38432 Echirolles Cedex, FRANCE

