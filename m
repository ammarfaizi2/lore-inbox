Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269067AbRIDOoP>; Tue, 4 Sep 2001 10:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRIDOoE>; Tue, 4 Sep 2001 10:44:04 -0400
Received: from mx6.port.ru ([194.67.57.16]:45074 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S269067AbRIDOnv>;
	Tue, 4 Sep 2001 10:43:51 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109041906.f84J6av02406@vegae.deep.net>
Subject: rmap3 test results (fwd)
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Sep 2001 19:06:35 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  root wrote:"
>From root Tue Sep  4 15:35:00 2001
Subject: rmap3 test results
To: linux-kernel@vger.kenel.org
Date: Tue, 4 Sep 2001 15:35:00 +0000 (UTC)
Cc: riel@surriel.com, marcelo@conectiva.com.br
X-Mailer: ELM [version 2.5 PL6]
Content-Length: 2710      

        Hello, guys here are some long-run results under different loads.
    actually i`d better limit my ram from 24M to 12 or 16M, but it is
    done the way it is done...

     * -j results have 4 of `em because of occasional sig11`s
     * each test was done 7 times and the least with the most were thrown away
     * on -j rmap3 significantly wins on system time

            =========[ vanilla ac12 ]=========
        LOAD == -j1     LOAD == -j4     LOAD == -j6
real    1m1.215s        1m2.360s        1m3.162s
real    1m1.390s        1m2.727s        1m3.568s
real    1m1.193s        1m2.553s        1m3.566s
real    1m1.573s        1m2.801s        1m3.625s
real    1m1.350s        1m2.279s        1m3.511s
sys     0m11.480s       0m12.250s       0m11.820s
sys     0m11.500s       0m12.430s       0m12.050s
sys     0m11.280s       0m12.270s       0m12.590s
sys     0m11.350s       0m11.830s       0m12.760s
sys     0m11.310s       0m11.770s       0m12.360s

            =========[ ac12 - rmap3 ]=========
        LOAD == -j1     LOAD == -j4     LOAD == -j6
real    1m2.435s        1m2.891s        1m3.699s
real    1m2.293s        1m2.402s        1m3.498s
real    1m2.055s        1m2.850s        1m3.633s
real    1m1.893s        1m2.566s        1m3.507s
real    1m1.814s        1m2.686s        1m3.726s
sys     0m11.840s       0m12.020s       0m12.530s
sys     0m11.650s       0m11.840s       0m12.390s
sys     0m11.490s       0m11.850s       0m12.530s
sys     0m11.770s       0m11.920s       0m12.330s
sys     0m11.690s       0m11.920s       0m12.270s

            =========[ vanilla ac12 ]=========
        LOAD == -j8     LOAD == -j10    LOAD == -j
real    1m5.139s        1m6.224s        9m27.874s
real    1m4.823s        1m6.522s        10m9.898s
real    1m4.832s        1m6.164s        9m54.544s
real    1m4.624s        1m7.004s        9m49.767s
real    1m4.715s        1m6.629s
sys     0m12.720s       0m13.480s       0m37.710s
sys     0m12.930s       0m13.770s       0m37.160s
sys     0m12.620s       0m13.340s       0m39.990s
sys     0m12.680s       0m13.890s       0m37.710s
sys     0m12.780s       0m13.810s

            =========[ ac12 - rmap3 ]=========
        LOAD == -j8     LOAD == -j10    LOAD == -j
real    1m5.211s        1m6.937s        10m37.020s
real    1m5.414s        1m6.894s        10m46.712s
real    1m5.055s        1m6.381s        10m1.204s
real    1m5.237s        1m6.590s        10m25.298s
real    1m5.161s        1m6.571s
sys     0m13.460s       0m13.430s       0m34.590s
sys     0m13.340s       0m13.630s       0m33.700s
sys     0m13.260s       0m13.670s       0m33.560s
sys     0m13.140s       0m13.760s       0m35.130s
sys     0m13.160s       0m13.350s

cheers,
 Sam



