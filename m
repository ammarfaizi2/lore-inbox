Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbUDQNHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 09:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbUDQNHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 09:07:40 -0400
Received: from massena-8-82-225-77-14.fbx.proxad.net ([82.225.77.14]:17804
	"EHLO picsou.chatons.dyndns.org") by vger.kernel.org with ESMTP
	id S263969AbUDQNHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 09:07:39 -0400
Message-ID: <40812C19.806@ens.fr>
Date: Sat, 17 Apr 2004 15:07:37 +0200
From: David Monniaux <David.Monniaux@ens.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: retries on bad blocks on screwed-up IDE drives
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to make a physical copy of a failing IDE drive. The problem is, 
I don't know in advance where the bad sectors lie. As a consequence, the 
copying process tries to copy those sectors; for each failing sector, 
the kernel tries, gets an error, tries again etc...

Is it possible to ask the kernel to give up immediately on a failed IDE 
sector?

Regards.

