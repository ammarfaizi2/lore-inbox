Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUFCG0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUFCG0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUFCG0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:26:41 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:41970 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261206AbUFCG0j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:26:39 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       bilotta78@hotpop.com, vojtech@suse.cz, tuukkat@ee.oulu.fi
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2)
References: <200406020218.42979.dtor_core@ameritech.net>
	<20040602003626.4d754944.akpm@osdl.org>
	<200406030045.51102.dtor_core@ameritech.net>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
In-Reply-To: <200406030045.51102.dtor_core@ameritech.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 03 Jun 2004 08:26:36 +0200
Message-ID: <xb7llj540o3.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    Dmitry> +config INPUT_RAWDEV
    Dmitry> +	tristate "Raw access to serio ports"
    Dmitry> +	depends on INPUT && INPUT_MISC
    Dmitry> +	help

Since this provides raw access  to serio ports ONLY, shouldn't it also
depend on INPUT_SERIO?  Shall we better call it SERIO_RAW?


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

