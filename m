Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTH1N0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTH1N0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:26:42 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:58534 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264002AbTH1N0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:26:41 -0400
Date: Thu, 28 Aug 2003 15:26:38 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828132638.GA23151@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1062063331.1459.263.camel@hurina> <Pine.LNX.4.44.0308280309550.14580-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0308280309550.14580-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003, Nagendra Singh Tomar wrote:

> If the writer does not want the reader to read old data why does'nt it 
> truncate the file and start writing from the begining every time.

To give you some background: Timo wants to store cache data in these
lockless. When these caches are truncated, they can be dropped
altogether, but the application's performance will drop drastically.

-- 
Matthias Andree
Encrypted mail solicited                Verschlüsselte Mail erwünscht
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x052E7D95
-> http://www.gnupg.org/(en)/related_software/frontends.html
