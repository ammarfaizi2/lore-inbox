Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWFNWzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWFNWzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFNWzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:55:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61620 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964985AbWFNWzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:55:14 -0400
Message-ID: <449093D6.6000806@engr.sgi.com>
Date: Wed, 14 Jun 2006 15:55:18 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Chris Sturtivant <csturtiv@sgi.com>
Subject: ON/OFF control of taskstats accounting data at do_exit
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir and Shailabh,

I propose we add the capability to turn ON/OFF the multicase of
taskstats accounting data at do_exit().

This would allow 'chkconfig taskstats' like of control similar
to 'chkconfig acct' for BSD accounting. Sometimes sysadmins would
wish to turn off sending accounting data to the multicast socket.
We have seen many situations that our CSA customers need to turn
off CSA for a period of time.

I think this feature is very important to this new interface.

Thanks,
 - jay

