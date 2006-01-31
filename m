Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWAaS7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWAaS7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWAaS7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:59:34 -0500
Received: from 172.red-82-159-197.user.auna.net ([82.159.197.172]:33513 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S1751349AbWAaS7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:59:33 -0500
From: Carlos =?iso-8859-1?q?Mart=EDn?= <carlos@cmartin.tk>
To: "Gabriel C." <da.crew@gmx.net>
Subject: Re: 2.6.16-rc1-mm4: ACX=y, ACX_USB=n compile error
Date: Tue, 31 Jan 2006 19:59:39 +0100
User-Agent: KMail/1.9.1
Cc: Denis Vlasenko <vda@ilport.com.ua>, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>,
       Adrian Bunk <bunk@stusta.de>, netdev@vger.kernel.org
References: <20060130133833.7b7a3f8e@zwerg> <200601311658.09423.vda@ilport.com.ua> <20060131193443.5822661b@zwerg>
In-Reply-To: <20060131193443.5822661b@zwerg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601311959.39285.carlos@cmartin.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 19:34, Gabriel C. wrote:
> 
> I'm not a kernel hacker :-) and mabye I'm wrong but why not auto select
> ACX_{PCI,USB} ?

They can still be both unselected, and that's where the problem lies.

Would it work if you added '&& (ACX_USB || ACX_PCI)' to the end of the 
'depends' line, or would that just make it unselectable? 

   cmn
-- 
Carlos Martín       http://www.cmartin.tk

"Erdbeben? Sicherlich etwas, das mit Erdberen zu tun hat." -- me, paraphrased
