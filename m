Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTIUUa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTIUUa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:30:28 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:5317 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S262564AbTIUUaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:30:23 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-bk8: synaptics still losing sync
Date: Sun, 21 Sep 2003 22:30:19 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309212230.19949.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter (and Vojtech),
	I just tried -bk8 to see if synaptics behaves better in my Dell Latitude 
X200. It still gives the following errors:

Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.
Synaptics driver lost sync at 1st byte
...

The pointer blocks for a few tenths of seconds when the driver loses 
synchronisation. It normally happens when movin windows or starting new 
kde applications, so I think it's cpu's load related.

If I disable cpudyn (which changes the cpu speed dynamically), it seems to 
me that it works a little better.

Regards,

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

