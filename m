Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTJMOzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJMOzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:55:17 -0400
Received: from gaia.cela.pl ([213.134.162.11]:61711 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261777AbTJMOy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:54:59 -0400
Date: Mon, 13 Oct 2003 16:54:39 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Chuck Campbell <campbell@accelinc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens
 to them?
In-Reply-To: <20031013142402.GA6244@helium.inexs.com>
Message-ID: <Pine.LNX.4.44.0310131653410.20116-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> find /usr/lib -type f|sed -e 's!.*!cat & >/dev/null || echo &!'|sh
should obviously be:
  find /usr/lib -type f|sed -e 's!.*!cat "&" >/dev/null || echo &!'|sh
in order to accept spaces in file names... (they do happen).

MaZe.

