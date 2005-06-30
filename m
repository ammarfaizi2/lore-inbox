Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVF3SVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVF3SVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbVF3SVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:21:50 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:29925
	"HELO fargo") by vger.kernel.org with SMTP id S262672AbVF3SVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:21:48 -0400
Date: Thu, 30 Jun 2005 20:18:25 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with inotify
Message-ID: <20050630181824.GA1058@fargo>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all ;),

I just patched 2.6.12 kernel with the inotify latest patch
(inotify-0.23-rml-2.6.12-14.patch). Inotify is working ok with the test program
provided in inotify-utils but... I can no longer mount my IDE cdrom devices
:(. Each time i try to mount a disc, the mount proccess get stuck in D state. I
don't see what's the relation between inotify and IDE devices, but if i switch
back to the unpatched 2.6.12, mounting works again.

Any ideas? Thanks

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
