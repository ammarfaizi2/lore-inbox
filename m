Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTDPTI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTDPTI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:08:57 -0400
Received: from fmr01.intel.com ([192.55.52.18]:58067 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264543AbTDPTI4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:08:56 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBB10B@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] /sbin/hotplug multiplexor - take 2
Date: Tue, 15 Apr 2003 17:01:40 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Greg KH [mailto:greg@kroah.com]
>
> ...
>
> for I in "${DIR}/$1/"* "${DIR}/"all/* ; do
> 	test -x $I && $I $1 ;

test -x "$I" && "$I" "$1"

Just in case?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
