Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264793AbSKEKpM>; Tue, 5 Nov 2002 05:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSKEKpM>; Tue, 5 Nov 2002 05:45:12 -0500
Received: from mx7.mail.ru ([194.67.57.17]:48393 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S264793AbSKEKpK>;
	Tue, 5 Nov 2002 05:45:10 -0500
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [RFC] FS charset conversions
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Tue, 05 Nov 2002 13:51:43 +0300
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1891J9-000B9X-00@f15.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        The problem root lies in the fact in some languages (notably russian)
    there is more then one widely used charset. In russian for example
    there are koi8-r, iso8859-5, cp866 and the infamous but widely used
    ms cp1251.

        Once you need to have access to some data with names using the second
    half of the ascii table the trouble arises. For example the situation
    i have here is that smbd provides the public share and people creates
    there some files originating with the cp1251 encoding. Myself having
    koi8-r as the system default charset naturally observe crap.

        The proposed and seemingly natural solution is to add a possibility
    to mount --bind the subtree with a filename charset conversion applied.


regards, Samium Gromoff

______________________________________
__________________________________

