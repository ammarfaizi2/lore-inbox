Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUFONxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUFONxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFONxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:53:51 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:44416 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265544AbUFONwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:52:24 -0400
Date: Tue, 15 Jun 2004 13:52:24 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Cross dependency of make menuconfig entried
Message-ID: <20040615135224.A6090@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have discovered that make menuconfig entries are inclusively cross-dependent.
It means that if I disable and re-enable something that masks more entries,
the entries are reset into their default state.

Toggling one checkbox can apparently cause toggling of another checkbox of the
another checkbox is masked by the first checkbox.

I would like to know if toggling one checkbox can cause toggling another
checkbox even in the case the second checkbox is not masked by the first one.

Cl<
