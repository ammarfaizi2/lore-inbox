Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933684AbWKTIGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933684AbWKTIGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933994AbWKTIGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:06:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59843 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933684AbWKTIGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:06:00 -0500
Subject: Re: path_lookup for executable
From: Arjan van de Ven <arjan@infradead.org>
To: e m <eyubo@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY107-F318881FF4ADDFBA789F97BABED0@phx.gbl>
References: <BAY107-F318881FF4ADDFBA789F97BABED0@phx.gbl>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 20 Nov 2006 09:05:57 +0100
Message-Id: <1164009958.31358.564.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 04:00 +0000, e m wrote:
> I am trying to get inode for an executable program. For example, I wish to 
> get inode for /usr/jdk/bin/java file in a module. The following call always 
> return an error. Is there a way to get the inode of current process, 
> assuming I have access to "current"


Hi,

what makes you think the current executable has any meaning? It can be
unlinked, renamed or moved in the directory hierarchy since the program
was started... (and if you would go by inode number.. then there's
multiple answers possible)


