Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTHGS3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbTHGS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:29:46 -0400
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:4480 "EHLO topaz")
	by vger.kernel.org with ESMTP id S270327AbTHGS3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:29:46 -0400
To: linux-kernel@vger.kernel.org
Subject: yenta socket datapoint
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 07 Aug 2003 13:29:40 -0500
Message-ID: <87smod5njf.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.0-test2-mm5 on my thinkpad t21, and i have noticed
the following. If yenta_socket support is built as a module, and
loaded by the pcmcia init script, pcmcia cards already inserted are
recognized on startup. If you build yenta_socket support into the
kernel, these cards aren't seen, and require a replug to work.
 -nld
